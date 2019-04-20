import * as React from 'react';
import {Login} from "./ui/login";
import {FriendList} from "./ui/friend_list";
import {View} from "react-native";
import {TalkSession} from "./ui/talk_session";


export default class Main extends React.Component {
    constructor(props: any) {
        super(props);
        this.state = {};
    }


    render(): React.ReactNode {
        return (
            <View>
                {/*<Login/>*/}
                {/*<FriendList/>*/}
                <TalkSession />
            </View>
        );
    }

}

