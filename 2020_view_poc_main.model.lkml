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
    sql_on: ${rental.rental_id} = ${order_sequence_current.rental_id};;
  }
  join: order_sequence_next {
    from: order_sequence
    relationship: one_to_one
    sql_on: ${order_sequence_current.customer_id} = ${order_sequence_next.customer_id}
    and ${order_sequence_current.rental_seq} +1 = ${order_sequence_next.rental_seq};;
  }

  # additional info about film

  join: film {
    relationship: many_to_one
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
  }
    join: language {
      view_label: "Film"
      relationship: many_to_one
      sql_on: ${film.language_id} = ${language.language_id} ;;
      fields: [language.name]
    }
  join: film_category {
    relationship: many_to_one
    sql_on: ${inventory.film_id} = ${film_category.film_id} ;;
    fields: []
  }
      join: category {
        view_label: "Film"
        relationship: many_to_one
        sql_on: ${film_category.category_id} = ${category.category_id} ;;
        fields: [category.name]
      }
  join: film_actor {
    relationship: many_to_many
    sql_on: ${inventory.film_id} = ${film_actor.actor_id} ;;
    fields: []
  }
      join: actor {
        view_label: "Film"
        relationship: many_to_many
        sql_on: ${film_actor.actor_id} = ${actor.actor_id} ;;
        fields: [actor.name]
      }



}

explore: all_film_fact {
  join: rented_film_fact {
    relationship: one_to_one
    sql_on: ${all_film_fact.film_id} = ${rented_film_fact.film_id} ;;
  }
}
