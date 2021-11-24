# The name of this view in Looker is "Nicer But Slower Film List"
view: nicer_but_slower_film_list {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.nicer_but_slower_film_list`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Actors" in Explore.

  dimension: actors {
    type: string
    sql: ${TABLE}.actors ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: fid {
    type: number
    value_format_name: id
    sql: ${TABLE}.FID ;;
  }

  dimension: length {
    type: number
    sql: ${TABLE}.length ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }

  dimension: rating {
    type: string
    sql: ${TABLE}.rating ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: []
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_length {
    type: sum
    hidden: yes
    sql: ${length} ;;
  }

  measure: average_length {
    type: average
    hidden: yes
    sql: ${length} ;;
  }

  measure: total_price {
    type: sum
    hidden: yes
    sql: ${price} ;;
  }

  measure: average_price {
    type: average
    hidden: yes
    sql: ${price} ;;
  }
}
