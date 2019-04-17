/**
 * @format
 */

import {AppRegistry} from 'react-native';
// import Main from "./lib/src/Main";
import {ImuiComponent as Main} from "./src/imuiComponent"
import {name as appName} from './app.json';

AppRegistry.registerComponent(appName, () => Main);
