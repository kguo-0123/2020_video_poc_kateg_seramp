# The name of this view in Looker is "Film Actor"
view: film_actor {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-private-demo.video_store.film_actor`
    ;;

  dimension: actor_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.actor_id ;;
  }

  dimension: film_id {
    type: number
    # hidden: yes
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
  dimension: created_pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: concat(${film_id},${actor_id}) ;;
  }

}
