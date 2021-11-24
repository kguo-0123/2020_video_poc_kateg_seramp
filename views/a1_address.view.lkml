# The name of this view in Looker is "Address"
view: address {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.address`
    ;;
  drill_fields: [address_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: address_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.address_id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Address" in Explore.

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: city_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.city_id ;;
  }

  dimension: district {
    type: string
    sql: ${TABLE}.district ;;
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
  }

  dimension: phone {
    type: number
    sql: ${TABLE}.phone ;;
  }

  dimension: postal_code {
    type: number
    sql: ${TABLE}.postal_code ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [address_id, city.city_id]
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_phone {
    type: sum
    hidden: yes
    sql: ${phone} ;;
  }

  measure: average_phone {
    type: average
    hidden: yes
    sql: ${phone} ;;
  }

  measure: total_postal_code {
    type: sum
    hidden: yes
    sql: ${postal_code} ;;
  }

  measure: average_postal_code {
    type: average
    hidden: yes
    sql: ${postal_code} ;;
  }
}
