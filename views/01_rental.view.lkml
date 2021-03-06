# The name of this view in Looker is "Rental"
view: rental {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.rental`
    ;;
 # drill_fields: [rental_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.


  # ID ################
  dimension: rental_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.rental_id ;;
  }

  dimension: customer_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: inventory_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_id ;;
  }

  dimension: staff_id {
    type: number
    sql: ${TABLE}.staff_id ;;
  }

  # Date ###################
  dimension_group: last_update {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_update ;;
    hidden: yes

  }

  dimension_group: rental {
    type: time
    timeframes: [
      date,
      week,
      month,
      year,
      raw
    ]
    sql: ${TABLE}.rental_date ;;
  }

  dimension_group: return {
    type: time
    timeframes: [
      raw,

      date,
      week,
      month,

      year
    ]
    sql: ${TABLE}.return_date ;;
  }


# About Rental #####################

  dimension_group: rental_duration {
    type: duration
    sql_start: ${rental_raw} ;;
    sql_end: case when ${return_raw} is null then current_timestamp() else ${return_raw} end ;;
  }

  dimension: is_late_as_of_today {
    type: yesno
    sql: ${days_rental_duration} > 7  ;;
    group_label: "Status"
  }

  dimension: is_returned_as_of_today{
    type: yesno
    sql: ${return_raw} is not null ;;
    group_label: "Status"
  }

  # As of X (reference dat) -- used for snapshot analysis

  dimension: is_rented_as_of_x{
    type: yesno
    sql: ${calendar.date_x_date} between ${rental_date} and COALESCE(${return_date}, current_date());;
    view_label: "OOS & Late Rental History"
  }

  dimension: rental_duration_as_of_x{
    type: number
    sql:
      case
        when ${is_rented_as_of_x} is false then null
        else TIMESTAMP_DIFF(${calendar.date_x_date},${rental_date},day)
        end;;
    view_label: "OOS & Late Rental History"
  }

  dimension: is_late_as_x {
    type: yesno
    sql: ${rental_duration_as_of_x} > 7  ;;
    view_label: "OOS & Late Rental History"
  }

  measure: count_of_rentals_as_of_x {
    type: count_distinct
    sql: ${rental_id} ;;
    filters: [is_rented_as_of_x: "yes"]
    view_label: "OOS & Late Rental History"
    drill_fields: [rental_details*]
  }

  measure: count_of_late_rentals_as_of_x {
    type: count_distinct
    sql: ${rental_id} ;;
    filters: [is_late_as_x: "yes"]
    view_label: "OOS & Late Rental History"
    drill_fields: [rental_details*]
  }

  measure: late_rental_rate_as_of_x {
    type: number
    value_format_name  : "percent_2"
    sql: 1.0*${count_of_late_rentals_as_of_x}/nullif(${count_of_rentals_as_of_x},0) ;;
    view_label: "OOS & Late Rental History"
    drill_fields: [inventory.store_id,late_rental_rate_as_of_x]
  }

# About next rental ##
  dimension:  has_next_rental{
    type: yesno
    sql: ${order_sequence_next.rental_id} is not null ;;
    group_label: "Status"
  }

  dimension_group: till_next_rental {
    type: duration
    intervals: [day]
    sql_start: ${rental_date} ;;
    sql_end: ${order_sequence_next.rental_date} ;;
    hidden: yes
  }

  dimension: days_till_next_rental_nullfilled {
    label: "Days Till Next Rental "
    type: number
    sql: coalesce(${days_till_next_rental}, 99999) ;;
    group_label: "Status"
  }

  # dimension: repeat_rental_within_30_days {
  #   type: yesno
  #   sql: ${days_till_next_rental} <= 30 ;;
  # }
  # dimension: repeat_rental_within_60_days {
  #   type: yesno
  #   sql: ${days_till_next_rental} <= 60 ;;
  # }

  # dimension: repeat_rental_within_90_days {
  #   type: yesno
  #   sql: ${days_till_next_rental} <= 90 ;;
  # }

  measure: average_days_till_next_rental {
    type: average
    sql: ${days_till_next_rental} ;;
  }

# Measures ##########################

  measure: count {
    type: count
  #  drill_fields: [rental_id, inventory.inventory_id, customer.customer_id, customer.first_name, customer.last_name]
    drill_fields: [rental_date,count]
  }

  measure: count_of_late_rentals {
    type: count
    filters: [is_late_as_of_today:  "Yes"]
  }

  measure: late_rental_rate {
    type: number
    sql: 1.0*${count_of_late_rentals}/nullif(${count},0) ;;
    label: "Late Rental Rate"
    value_format_name: percent_2
    description: "Percentage of late rental"
    drill_fields: [count, count_of_late_rentals]
    hidden: yes
  }

  measure: count_of_customers {
    type: count_distinct
    sql: ${customer_id} ;;
    drill_fields: [customer_id, customer.email, customer.first_name, customer.last_name]

  }

set: rental_details {
  fields: [rental_id,rental_date,return_date]
}




}
