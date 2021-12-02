# The name of this view in Looker is "Payment"
view: payment {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.payment`
    ;;
 # drill_fields: [payment_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: payment_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.payment_id ;;
    hidden: yes
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Amount" in Explore.

  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
    hidden: yes
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    hidden: yes
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  dimension_group: payment {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.payment_date ;;
  }

  dimension: rental_id {
    type: number
    sql: ${TABLE}.rental_id ;;
    hidden: yes
  }

  dimension: staff_id {
    type: number
    sql: ${TABLE}.staff_id ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [payment_id]
    hidden: yes
  }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
    value_format_name: "usd"
    drill_fields: [rental_id,total_amount]
    label: "Total Revenue"
  }

  measure: average_amount {
    type: average
    sql: ${amount} ;;
    hidden: yes
  }
}
