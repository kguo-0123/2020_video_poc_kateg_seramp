connection: "looker-private-demo"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project


explore: rental {
  sql_always_where: ${rental.rental_date} <= '2005-08-30' ;;
  join: inventory{
    relationship: many_to_one
    sql_on: ${rental.inventory_id} = ${inventory.inventory_id} ;;
    type: full_outer
  }
  join: store {
    relationship: many_to_one
    sql_on: ${inventory.store_id} = ${store.store_id} ;;
    type: full_outer
  }
  join: payment {
    relationship: one_to_one
    sql_on: ${rental.rental_id} = ${payment.rental_id} ;;
    view_label: "Revenue"
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
    type: full_outer
  }
  join: order_sequence_current {
    from: order_sequence
    #view_label: "Sequence Analysis"
    relationship: one_to_one
    sql_on: ${rental.rental_id} = ${order_sequence_current.rental_id} ;;
    fields: [order_sequence_current.rental_seq]
    view_label: "Rental"
  }
  join: order_sequence_next {
    from: order_sequence
    view_label: "Sequence Analysis"
    relationship: one_to_one
    sql_on: ${order_sequence_current.customer_id} = ${order_sequence_next.customer_id}
    and ${order_sequence_current.rental_seq} +1 = ${order_sequence_next.rental_seq};;
    fields: []
  }

  # additional info about film

  join: film {
    relationship: many_to_one
    sql_on: ${inventory.film_id} = ${film.film_id} ;;
    type: full_outer
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
    type: full_outer
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

  join: film_store_fact {
    relationship: many_to_one
    sql_on: ${calendar.date_x_date} = ${film_store_fact.date_x_date}
    and ${film.film_id} = ${film_store_fact.film_id} and ${store.store_id} = ${film_store_fact.store_id};;
    type: full_outer
    view_label: "OOS & Late Rental History"

  }

  # access_filter:  {
  #   field: inventory.store_id
  #   user_attribute: kg_test_store
  # }


}

#explore: film_store_fact {}