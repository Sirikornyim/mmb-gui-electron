const namespaced = true;

const state = {
  models: [],
  policyRules: [],
  shocks: [],
  outputVars: [],
};

const getters = {
  models(state) {
    return state.models;
  },
  policyRules(state) {
    return state.policyRules;
  },
  shocks(state) {
    return state.shocks;
  },
  outputVars(state) {
    return state.outputVars;
  },

  numModels(state) {
    return state.models.length;
  },
  numPolicyRules(state) {
    return state.policyRules.length;
  },
  numShocks(state) {
    return state.shocks.length;
  },
  numOutputVars(state) {
    return state.outputVars.length;
  },

  isShockDisabled(state, getters) {
    return (shock) => {
      const { models } = getters;

      return models.some((model) => {
        switch (shock.name) {
          case 'Mon':
            return !model.capabilities.mp_shock;
          case 'Fis':
            return !model.capabilities.fiscal_shock;
          default:
            throw new Error('isShockDisabled(): Unknown shock type.');
        }
      });
    };
  },

  isModelDisabled(state, getters) {
    return (model) => {
      const { shocks, policyRules } = getters;

      const hasUnsupportedRules = policyRules.some((rule) => {
        switch (rule.id) {
          case 1:
            return false;
          case 2:
            return !model.capabilities.model_specific_rule;
          default:
            return !model.capabilities.rules.includes(rule.id);
        }
      });

      const hasUnsupportedShocks = shocks.some((shock) => {
        console.log(shock.name, model.capabilities);
        switch (shock.name) {
          case 'Mon':
            return !model.capabilities.mp_shock;
          case 'Fis':
            return !model.capabilities.fiscal_shock;
          default:
            throw new Error('isShockDisabled(): Unknown shock type.');
        }
      });

      return hasUnsupportedRules || hasUnsupportedShocks;
    };
  },

  isRuleDisabled(state, getters) {
    return (id) => {
      switch (id) {
        case 1:
          // user specified
          return false;
        case 2:
          // model specific
          return getters.models.some(m => !m.capabilities.model_specific_rule);
        default:
          return getters.models.some(m => !m.capabilities.rules.includes(id));
      }
    };
  },

  canCompare(state, getters) {
    return getters.numModels
      && getters.numPolicyRules
      && getters.numShocks
      && getters.numOutputVars;
  },
};

const mutations = {
  setModels(state, data) {
    state.models = data;
  },
  setPolicyRules(state, data) {
    state.policyRules = data;
  },
  setShocks(state, data) {
    state.shocks = data;
  },
  setOutputVars(state, data) {
    state.outputVars = data;
  },

  clearModels(state) {
    state.models = [];
  },
  clearPolicyRules(state) {
    state.policyRules = [];
  },
  clearShocks(state) {
    state.shocks = [];
  },
  clearOutputVars(state) {
    state.outputVars = [];
  },

  clearAll(state) {
    state.models = [];
    state.policyRules = [];
    state.shocks = [];
    state.outputVars = [];
  },
};

const actions = {};

export default {
  namespaced,
  state,
  getters,
  mutations,
  actions,
};
