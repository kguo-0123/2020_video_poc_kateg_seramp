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
    hidden: yes
  }
  dimension: count {
    type: number
    label: "Lifetime Rentals"
    group_label: "Lifetime Value"
  }
  dimension: count_of_late_rentals {
    type: number
    label: "Lifetime Late Rentals"
    group_label: "Lifetime Value"
  }
  dimension: late_rental_rate {
    description: "Percentage of Late rental"
    value_format: "#,##0.00%"
    type: number
    label: "Lifetime Late rental rate"
    group_label: "Lifetime Value"
  }
  dimension: total_amount {
    type: number
    label: "Lifetime Spend"
    group_label: "Lifetime Value"
  }
  dimension: average_amount {
    type: number
    label: "Lifetime Average Spend"
    group_label: "Lifetime Value"
  }

  measure: average_count {
    type: average
    label: "Average Lifetime Rentals"
    group_label: "Lifetime Value"
    sql: ${count} ;;
    value_format_name: decimal_2
  }
  measure: average_count_of_late_rentals {
    type: average
    label: "Average Lifetime Late Rentals"
    group_label: "Lifetime Value"
    sql: ${count_of_late_rentals} ;;
    value_format_name: decimal_2
  }
  measure: average_late_rental_rate {
    type: average
    label: "Average Lifetime Late Rental Rate"
    group_label: "Lifetime Value"
    sql: ${late_rental_rate} ;;
    value_format_name: percent_2
  }
  measure: average_total_amount {
    type: average
    label: "Average Lifetime Spend"
    group_label: "Lifetime Value"
    sql: ${total_amount} ;;
    value_format_name: usd
  }

}
