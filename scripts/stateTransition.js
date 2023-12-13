/**
 * Given:
 * 1. Current State Vector
 * 2. Contract State Dependencies
 * 
 * We want to produce a stateParameter vector which can then be transacted.
 * This stateParameter vector should include all parameters that:
 * 1. Are 
 */


/**
 * How to manage non-frozen states?
 * We don't care about those values, we're only managing
 * frozen values. 
 * What we do offer is an atomic change from frozen to non-frozen
 * or initialization of a new freezable version.
 * 
 * Sometimes set non frozen on registry and sometimes not? 
 * 
 * Issue props up about organization. Is this variable now apart of the freezble
 * registry or does it exist in a facet somewhere?
 * 
 * Why would it need to be localized at the registry? We want one point of control
 * to manage inconsistencies between register and storage. 
 * 
 * Externals all managed in one place, constructors of course must stay at the facets.
 * This could make sense.
 * What would we be looking at now?
 * 
 * External version facet, complete with getters and setters and version hardcoded library.
 * 
 * 
 */