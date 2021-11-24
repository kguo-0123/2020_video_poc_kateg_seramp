# The name of this view in Looker is "Actor"
view: actor {

  sql_table_name: `looker-private-demo.video_store.actor`
    ;;
  drill_fields: [actor_id]

  dimension: actor_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.actor_id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    hidden: yes
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    hidden: yes
  }

  dimension: name {
    type: string
    sql: concat(${first_name},' ',${last_name}) ;;
    label: "Actor"
  }
}
