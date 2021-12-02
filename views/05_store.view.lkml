# The name of this view in Looker is "Store"
view: store {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.store`
    ;;
  #drill_fields: [store_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: store_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.store_id ;;
    link: {
      label: "Store {{ value }} Customer Behavior Dashboard"
      url: "https://seramp.dev.looker.com/dashboards-next/40?Lifetime+Rental+Sequence+%28N%29=1&Store+ID={{ value }}"
    }
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Address ID" in Explore.

  dimension: address_id {
    type: number
    sql: ${TABLE}.address_id ;;
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

  dimension: manager_staff_id {
    type: number
    sql: ${TABLE}.manager_staff_id ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [store_id, inventory.count, customer.count]
    hidden: yes
  }
}

# These sum and average measures are hidden by default.
# If you want them to show up in your explore, remove hidden: yes.
