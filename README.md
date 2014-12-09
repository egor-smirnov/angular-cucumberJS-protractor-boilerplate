# AngularJS + CucumberJS + Protractor Boilerplate

#Tech stack

JS for actual code and CoffeeScript for tests.

* Frontend: JavaScript / [AngularJS](https://angularjs.org/) / [AngularUI Router](https://github.com/angular-ui/ui-router) / [Browserify](http://browserify.org/)
* Build tools: [Gulp](http://gulpjs.com/) / [BrowserSync](http://www.browsersync.io/)
* Unit testing: [CoffeeScript](http://coffeescript.org/) / [Karma](http://karma-runner.github.io/) / [Mocha](http://mochajs.org/) / [Sinon](http://sinonjs.org/) / [Chai](http://chaijs.com/)
* e2e testing: [CoffeeScript](http://coffeescript.org/) / [Protractor](http://angular.github.io/protractor/) / [CucumberJS](https://github.com/cucumber/cucumber-js) / [Chai as Promised](http://chaijs.com/plugins/chai-as-promised)

#How to run

1. Install node.js if you don't have it.
2. Run `npm install gulp -g` (this will install gulp globally)
3. Clone this repository.
4. Cd to project repository.
5. Run `npm install`.
6. Run `gulp` (this will run default gulp task).
7. Run `gulp test` for running application unit tests / generating code coverage with mocked backend. Also take a look into coverage' directory - there will be code coverage in HTML format there.
8. Run `gulp e2e` for running CucumberJS e2e-scenario with mocked backend. Run and notice how the scenarios became green :).

#Available Gulp tasks

1. `gulp clean` - cleans project build directory 'dist/'
2. `gulp build` - builds assets of the project (currently JS, in the future it could be anything like SASS / uglyfying / concatenating JS etc.)
3. `gulp serve` - runs BrowserSync server for root directory with liveReload activated and runs watcher for changes of JS. Useful while developing. **Please note**, that in current state of repository real backend is not prepared, so application run by this command won't work because of failed HTTP requests. Only index or static route will work.
4. `gulp` or `gulp default` - combines all 3 above tasks in one
5. `gulp test` - runs unit tests once and generates code coverage (located in 'coverage' folder).
6. `gulp tdd` - runs command that continuously watches for changes in unit tests / app code and reruns unit tests / code coverage allowing you to actually use TDD approach. Should be used while development.
7. `gulp e2e` - runs CucumberJS scenarios.