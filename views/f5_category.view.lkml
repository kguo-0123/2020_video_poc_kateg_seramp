# The name of this view in Looker is "Category"
view: category {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.category`
    ;;
  drill_fields: [category_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: category_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.category_id ;;
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


  dimension: name {
    label: "Category"
    type: string
    sql: ${TABLE}.name ;;
  }
}
