# If necessary, uncomment the line below to include explore_source.
# include: "2020_view_poc_main.model.lkml"

view: film_store_fact {
  derived_table: {
    explore_source: rental {
      column: date_x_date { field: calendar.date_x_date }
      column: film_id { field: inventory.film_id }
      column: count_of_rented_as_of_x { field: inventory.count_of_rented_as_of_x }
      column: count { field: inventory.count }
      column: store_id { field: inventory.store_id }
    }
  }
  dimension: created_pk {
    type: string
    sql: concat(${date_x_date},${film_id},${store_id}) ;;
    hidden: yes
    primary_key: yes
  }
  dimension: date_x_date {
    label: "as of X date (x) Date"
    type: date
  }
  dimension: film_id {
    type: number
  }
  dimension: count_of_rented_as_of_x {
    label: "as of X Total Inventory Rented Count as of X"
    type: number
  }
  dimension: count {
    label: "Inventory Total Inventory Count"
    type: number
  }
  dimension: store_id {
    type: number
    link: {
      label: "Store {{ value }} Customer Behavior Dashboard"
      url: "https://seramp.dev.looker.com/dashboards-next/40?Lifetime+Rental+Sequence+%28N%29=1&Store+ID={{ value }}"
    }
  }

  dimension: rented_percentage  {
    type: number
    value_format_name: percent_2
    sql: 1.0*${count_of_rented_as_of_x} / nullif(${count},0) ;;
  }

  measure: average_rented_percentage {
    type: average
    sql: ${rented_percentage} ;;
    value_format_name: percent_2
  }
  measure: OOS_count {
    type: count
    filters: [rented_percentage: ">=1"]
    drill_fields: [store_id, film_id, film.title, OOS_count]
  }

}
