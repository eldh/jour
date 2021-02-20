/**
 * @format
 */

import {AppRegistry} from 'react-native';
import App from './App';
import {name as appName} from './app.json';
import * as List from 'bs-platform/lib/es6/list.mjs';
console.log('List', List);

AppRegistry.registerComponent(appName, () => App);
