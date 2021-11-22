# The name of this view in Looker is "Rental"
view: rental {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.rental`
    ;;
  drill_fields: [rental_id]
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
  }

  dimension_group: rental {
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
    sql: ${TABLE}.rental_date ;;
  }

  dimension_group: return {
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
    sql: ${TABLE}.return_date ;;
  }

  dimension: is_returned {
    type: yesno
    sql: ${return_raw} is not null ;;
  }

# About Rental #####################

  dimension_group: rental_duration {
    type: duration
    sql_start: ${rental_raw} ;;
    sql_end: case when ${return_raw} is null then current_timestamp() else ${return_raw} end ;;
  }
  dimension: is_late {
    type: yesno
    sql: ${days_rental_duration} > 7  ;;
  }


# Measures ##########################

  measure: count {
    type: count
    drill_fields: [rental_id, inventory.inventory_id, customer.last_name, customer.customer_id, customer.first_name]
  }

  measure: count_of_late_rentals {
    type: count
    filters: [is_late: "Yes"]
  }

  measure: late_rental_rate {
    type: number
    sql: 1.0*${count_of_late_rentals}/nullif(${count},0) ;;
    label: "Late Rental Rate"
    value_format_name: percent_2
    description: "Percentage of late rental"
    drill_fields: [count, count_of_late_rentals]
  }
}
