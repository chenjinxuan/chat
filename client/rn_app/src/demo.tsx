import * as React from 'react';
import {View} from 'react-native';

interface props {
    title?: any;
}

export default class  Demo extends React.Component<props> {
    render() {
        return (
            <View style = {{height: 100, width: 100, backgroundColor: 'red'}}>

            </View>
        )
    }
}
