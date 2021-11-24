# The name of this view in Looker is "Film"
view: film {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.film`
    ;;
  drill_fields: [film_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: film_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.film_id ;;
    hidden: yes
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: language_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.language_id ;;
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

  dimension: length {
    type: number
    sql: ${TABLE}.length ;;
  }

  dimension: original_language_id {
    type: string
    sql: ${TABLE}.original_language_id ;;
    hidden: yes
  }

  dimension: rating {
    type: string
    sql: ${TABLE}.rating ;;
  }

  dimension_group: release_year {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.release_year ;;
  }

  dimension: rental_duration {
    type: number
    sql: ${TABLE}.rental_duration ;;
  }

  dimension: rental_rate {
    type: number
    sql: ${TABLE}.rental_rate ;;
  }

  dimension: replacement_cost {
    type: number
    sql: ${TABLE}.replacement_cost ;;
  }

  dimension: special_features {
    type: string
    sql: ${TABLE}.special_features ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }


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

  measure: total_rental_duration {
    type: sum
    hidden: yes
    sql: ${rental_duration} ;;
  }

  measure: average_rental_duration {
    type: average
    hidden: yes
    sql: ${rental_duration} ;;
  }

  measure: total_rental_rate {
    type: sum
    hidden: yes
    sql: ${rental_rate} ;;
  }

  measure: average_rental_rate {
    type: average
    hidden: yes
    sql: ${rental_rate} ;;
  }

  measure: total_replacement_cost {
    type: sum
    hidden: yes
    sql: ${replacement_cost} ;;
  }

  measure: average_replacement_cost {
    type: average
    hidden: yes
    sql: ${replacement_cost} ;;
  }
}
