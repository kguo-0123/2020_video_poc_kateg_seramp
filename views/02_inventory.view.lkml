# The name of this view in Looker is "Inventory"
view: inventory {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.inventory`
    ;;
  drill_fields: [inventory_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: inventory_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.inventory_id ;;
  }

  dimension: film_id {
    type: number
    sql: ${TABLE}.film_id ;;
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
    hidden: yes
  }

  dimension: store_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.store_id ;;
  }

  measure: count {
    type: count
    label: "Total Inventory Count"
  }

  measure: count_of_rented_as_of_x {
    type: count
    filters: [rental.is_rented_as_of_x: "Yes"]
    label: "Total Inventory Rented Count as of X"
    view_label: "as of X"
  }

  measure: rental_rate {
    type: number
    sql: 1.0*${count_of_rented_as_of_x} / nullif(${count},0);;
    value_format_name: percent_2
    view_label: "as of X"
  }

  measure: OOS_flag_2 {
    type: number
    sql: case when 1.0*${count_of_rented_as_of_x} / nullif(${count},0) >= 1 then '1' else '0' end;;
    view_label: "as of X"
  }



}
