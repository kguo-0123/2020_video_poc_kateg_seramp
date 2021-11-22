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

}

explore: all_film_fact {
  join: rented_film_fact {
    relationship: one_to_one
    sql_on: ${all_film_fact.film_id} = ${rented_film_fact.film_id} ;;
  }
}
