# If necessary, uncomment the line below to include explore_source.
# include: "2020_view_poc_main.model.lkml"

view: customer_fact {
  view_label: "Customer"
  derived_table: {
    explore_source: rental {
      column: customer_id {}
      column: count {}
      column: count_of_late_rentals {}
      column: late_rental_rate {}
      column: total_amount { field: payment.total_amount }
      column: average_amount { field: payment.average_amount }
    }
    ##persist_for: "24 hours"
    ##datagroup_trigger:

  }
  dimension: customer_id {
    type: number
    primary_key: yes
  }
  dimension: count {
    type: number
    label: "Lifetime Rentals"
  }
  dimension: count_of_late_rentals {
    type: number
    label: "Lifetime Late Rentals"
  }
  dimension: late_rental_rate {
    description: "Percentage of Late rental"
    value_format: "#,##0.00%"
    type: number
    label: "Lifetime Late rental rate"
  }
  dimension: total_amount {
    type: number
    label: "Lifetime Spend"
  }
  dimension: average_amount {
    type: number
    label: "Lifetime Average Spend"
  }

  measure: average_count {
    type: average
    label: "Average Lifetime Rentals"
    sql: ${count} ;;
    value_format_name: decimal_2
  }
  measure: average_count_of_late_rentals {
    type: average
    label: "Average Lifetime Late Rentals"
    sql: ${count_of_late_rentals} ;;
    value_format_name: decimal_2
  }
  measure: average_late_rental_rate {
    type: average
    label: "Average Lifetime Late Rental Rate"
    sql: ${late_rental_rate} ;;
    value_format_name: percent_2
  }
  measure: average_total_amount {
    type: average
    label: "Average Lifetime Spend"
    sql: ${total_amount} ;;
    value_format_name: usd
  }

}
