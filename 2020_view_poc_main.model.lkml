connection: "looker-private-demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


explore: rental {
  join: inventory{
    relationship: many_to_one
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
  }
  join: store {
    relationship: many_to_one
    sql_on: ${inventory.store_id} = ${store.store_id} ;;
  }
  join: payment {
    relationship: one_to_one
    sql_on: ${rental.rental_id} = ${payment.rental_id} ;;
  }
  join: calendar {
    relationship: many_to_one
    type: cross
  }
  join: customer_fact {
    relationship: many_to_one
    sql_on: ${rental.customer_id}=${customer_fact.customer_id} ;;
  }
  join: customer {
    relationship: many_to_one
    sql_on: ${rental.customer_id} = ${customer.customer_id} ;;
  }
  join: order_sequence_current {
    from: order_sequence
    relationship: one_to_one
    sql: ${rental.rental_id} = ${order_sequence_current.rental_id};;
  }
  join: order_sequence_next {
    from: order_sequence
    relationship: one_to_one
    sql: ${rental.rental_id} = ${order_sequence_next.rental_id};;
  }

}

explore: all_film_fact {
  join: rented_film_fact {
    relationship: one_to_one
    sql_on: ${all_film_fact.film_id} = ${rented_film_fact.film_id} ;;
  }
}
