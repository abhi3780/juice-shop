'use strict'

exports.config = {
  directConnect: true,

  allScriptsTimeout: 80000,

  specs: [
    'test/e2e/*.js'
  ],

  capabilities: {
    'browserName': 'chrome',
    'chromeOptions': {
      'args': ['--window-size=1690,1000']
    },
    'proxy': {
    	'proxyType': 'manual',
    	'httpProxy': '35.159.17.15:8888'
  	}
  },

  baseUrl: 'http://localhost:3000',

  framework: 'jasmine2',

  jasmineNodeOpts: {
    showColors: true,
    defaultTimeoutInterval: 100000
  },

  onPrepare: function () {
    var jasmineReporters = require('jasmine-reporters')
    jasmine.getEnv().addReporter(new jasmineReporters.JUnitXmlReporter({
      consolidateAll: true,
      savePath: 'build/reports/e2e_results'
    }))
  }
}
