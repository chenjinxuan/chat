import * as React from 'react';
// import Login from "./ui/login";
// import FriendList from "./ui/friend_list";
import {Button, View} from "react-native";
import Login from "./Login";
import TalkSession from "./TalkSession";
// import TalkSession from "./ui/talk_session";


export default class Main extends React.Component {
    constructor(props: any) {
        super(props);
        this.state = {}

    }


    render(): React.ReactNode {


        return (
            <View>
                {/*<Login/>*/}
                {/*<FriendList/>*/}

                <Button title={"跳转聊天"} onPress={() => this.GotoTalkSession()}/>
            </View>
        );
    }

    GotoTalkSession() {
        // @ts-ignore
        navigate('TalkSession')
    }

}

