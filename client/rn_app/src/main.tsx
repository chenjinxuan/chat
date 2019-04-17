import * as React from 'react';
import {FlatList, StyleSheet, TextComponent, View, Text} from 'react-native';

interface props {
    title?: any;
}

export default class Main extends React.Component<props> {
    constructor(props: props) {
        super(props);
        this.state = {};
    }


    requestData = () => {
        const url = 'https://api.github.com/users/futurechallenger/repos';
        fetch(url).then(res => {
            console.log('started fetch');
            return res.json()
        }).then(res => {

            this.setState({
                // @ts-ignore
                data: [...this.state.data, ...res],
                error: res.error || null,
                laoding: false,
                refreshing: false,
            });
        }).catch(err => {
            console.log('==> fetch error', err);
            this.setState({error: err, loading: false, refreshing: false});
        });
    };


    render(): React.ReactNode {


        return (
            <Text>nihao</Text>
        );
    }

}

