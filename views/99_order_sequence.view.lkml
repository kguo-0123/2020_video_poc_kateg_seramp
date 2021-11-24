view: order_sequence {
  derived_table: {
    sql: select
    rental_id,
    customer_id,
    rental_date,
    dense_rank() over (partition by customer_id order by rental_date) as rental_seq
    from video_store.rental   ;;
  }


  dimension: rental_id {
    type: number
    sql: ${TABLE}.rental_id ;;
    primary_key: yes
  }

  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
  }

  dimension: rental_seq {
    type: number
    sql: ${TABLE}.rental_seq ;;
  }

  dimension_group: rental {
    type: time
    timeframes: [date]
    sql: ${TABLE}.rental_date ;;
  }


}
