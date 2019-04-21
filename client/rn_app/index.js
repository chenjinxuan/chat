/**
 * @format
 */
import { StackNavigator } from 'react-navigation';
import {AppRegistry} from 'react-native';
import Main from "./src/navigator/Main";
import TalkSession from "./src/navigator/TalkSession"
import {name as appName} from './app.json';

export default App = StackNavigator({
    Home: {
        screen: Main,
    },
    TalkSession: {
        screen: TalkSession
    }
}, {
    initialRouteName:'TalkSession',
})
AppRegistry.registerComponent(appName, () => App);
