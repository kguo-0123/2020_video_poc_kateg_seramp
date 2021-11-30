# The name of this view in Looker is "Customer"
view: customer {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.customer`
    ;;
  #drill_fields: [customer_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: customer_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Active" in Explore.

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }

  dimension: address_id {
    type: number
    sql: ${TABLE}.address_id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: create {
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
    sql: ${TABLE}.create_date ;;
  }

  # to be removed!
  dimension_group: create_dummy_data {
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
    sql: DATETIME_ADD(DATETIME "2003-01-01 00:00:00", INTERVAL ${customer_id} DAY) ;;
  }


  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    action: {
      label: "Send Return Reminder E-mail"
      url: "https://hooks.zapier.com/illustrative"
      icon_url: "https://www.google.com/s2/favicons?domain=www.mailchimp.com"
      form_param: {
        name: "Customer ID"
        type: string
        default: "{{ customer_id._value }}"
      }
      form_param: {
        name: "Customer ID"
        type: string
        default: "{{ email._value }}"
      }

      form_param: {
        name: "Subject"
        type: string
        default: "Reminder: Your Rental Return is Due"
      }

      form_param: {
        name: "Body"
        type: string
        default: " Hi {{ full_name._value }}, thanks for choosing 2020 Video! This is a friendly reminder that your current rental is due for return."
      }
    }
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    label: "Name"
    type: string
    sql: concat(${first_name},' ',${last_name}) ;;
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

  dimension: store_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.store_id ;;
    link: {
      label: "Store {{ value }} Customer Behavior Dashboard"
      url: "https://seramp.dev.looker.com/dashboards-next/40?Lifetime+Rental+Sequence+%28N%29=23&Store+ID={{ value }}"
    }
  }


  # A measure is a field that uses a SQL aggregate function. Here are count, sum, and average
  # measures for numeric dimensions, but you can also add measures of many different types.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: count {
    type: count
    drill_fields: [customer_id, last_name, first_name, store.store_id, rental.count]
  }

  # These sum and average measures are hidden by default.
  # If you want them to show up in your explore, remove hidden: yes.

  measure: total_active {
    type: sum
    hidden: yes
    sql: ${active} ;;
  }

  measure: average_active {
    type: average
    hidden: yes
    sql: ${active} ;;
  }
}
