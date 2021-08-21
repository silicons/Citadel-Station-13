/**
 * Anomalous energies can be nullified.
 *
 * This usually comes in the form of a nullification projector, but we're going to generalize this.
 */

/**
 * Gets the nullification on a turf
 *
 * @params
 * * T - turf
 * * P - particle datum instance
 * * power - the power of the projection
 * * intensity - the intensity of the effect
 * * mode - what mode the particle projection is acting with, e.g. destructive, nulling, constructive, ettc
 * * projection - what type of projection the particle is projected with, e.g. beam, self, field, etc
 * * variables - list of exotic_property instances to values
 */
/proc/get_exotic_nullify_turf(turf/T, datum/exotic_particle/P, power, intensity, mode, projection, properties, list/variables)

/**
 * Gets the nullification on a atom
 *
 * @params
 * * A - atom
 * * P - particle datum instance
 * * power - the power of the projection
 * * intensity - the intensity of the effect
 * * mode - what mode the particle projection is acting with, e.g. destructive, nulling, constructive, ettc
 * * projection - what type of projection the particle is projected with, e.g. beam, self, field, etc
 * * variables - list of exotic_property instances to values
 */
/proc/get_exotic_nullify_atom(atom/A, datum/exotic_particle/P, power, intensity, mode, projection, properties, list/variables)
