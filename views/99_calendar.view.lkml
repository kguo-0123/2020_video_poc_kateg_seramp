

view: calendar {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
          *
          FROM
          UNNEST(GENERATE_TIMESTAMP_ARRAY('2005-05-24', '2006-02-14', INTERVAL 1 DAY)) as DATE_x
      ;;
      sql_trigger_value: select 1  ;;
  }

  dimension_group: date_x {
    view_label: "as of X"
    label: "date (x)"
    type: time
    timeframes: [date]
    sql: ${TABLE}.DATE_x ;;

  }
  dimension: created_pk {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${date_x_date} ;;

  }


}
