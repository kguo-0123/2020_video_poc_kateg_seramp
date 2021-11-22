view: all_film_fact {
  derived_table: {
    sql: Select
        film_id,
        count(*) as films
        FROM inventory
        group by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: film_id {
    type: number
    sql: ${TABLE}.film_id ;;
  }

  dimension: films {
    type: number
    sql: ${TABLE}.films ;;
  }

  dimension: rented_percentage  {
    type: number
    value_format_name: percent_2
    sql: 1.0*${rented_film_fact.films} / nullif(${films},0) ;;
  }


  dimension: is_OOS {
    type: yesno
    sql: ${rented_percentage} = 1  ;;
  }

  measure: average_rented_percentage {
    type: average
    sql: ${rented_percentage} ;;
    value_format_name: percent_2
  }

  set: detail {
    fields: [film_id, films]
  }
}
