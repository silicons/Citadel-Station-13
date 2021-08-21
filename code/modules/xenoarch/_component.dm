/**
 * Xenoarcheology module
 *
 * Full ground-up rewrite inspired by bay xenoarch system.
 * Instead of having finds be either machinery with triggers/effects and items, we make the entire system a component.
 *
 * This component can be applied to almost anything and is in charge of providing anomalous effects.
 * Said effects, however, may only make sense or work on some things vs others.
 *
 * Anomalies are generated with 3 values: rarity, danger, and activity.
 * Rarity determines how rare the effects and particles are
 * Danger determines how dangerous it'll be
 * Activity determiness how functional it still is - up to still functioning while buried in a rock.
 *
 * Anomalies have power and particles.
 * Power is used by effects and also determines strength.
 * This is naturally regenerated at a constant rate, but can be boosted by some effects.
 * Particles are emitted passively at a slow rate depending on what effects/particles it has, or,
 * at a vastly higher rate while active.
 */
/datum/component/anomaly

