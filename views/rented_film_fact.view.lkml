view: rented_film_fact {
  derived_table: {
    sql: Select
        film_id,
        count(*) as films
        FROM inventory
        LEFT JOIN rental on rental.inventory_id = inventory.inventory_id
        CROSS JOIN
        WHERE rental.return_date is NULL
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

  set: detail {
    fields: [film_id, films]
  }
}
