import {Component} from "react";
import * as React from "react";
import {View, Text} from "react-native";

interface State {
    userName: string,
    password: string,
}

const users = [
    {
        name: 'brynn',
        avatar: 'https://s3.amazonaws.com/uifaces/faces/twitter/brynn/128.jpg'
    },
];

export default class Login extends Component<any, State> {
    constructor(props: any) {
        super(props);
        this.state = {userName: "", password: ""}
    }

    render(): React.ReactNode {
        return (
            <View>
                <Text>
                    如果你喜欢在Web上使用React，那你也肯定会喜欢React Native.
                </Text>
                <Text>
                    基本上就是用原生组件比如'View'和'Text'
                    来代替web组件'div'和'span'。
                </Text>
                {/*<Button />*/}
                {/*<Image */}
                {/*source={{uri: "https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=1225408202,1465836771&fm=179&app=42&f=PNG?w=121&h=140"}}*/}
                {/*style={{width: 250, height: 250, marginHorizontal: 100, marginVertical: 50}}/>*/}
                {/*<Input placeholder="输入账号" value={this.state.userName} onChangeText={(text) => {*/}
                {/*this.setState({userName: text})*/}
                {/*}}/>*/}
                {/*<Input placeholder="输入密码" value={this.state.password} onChangeText={(text) => {*/}
                {/*this.setState({password: text})*/}
                {/*}}/>*/}
                {/*<Button title="登录" onPress={() => this.login()}/>*/}
                {/*<Divider/>*/}
                {/*<Button title="注册" onPress={() => this.register()}/>*/}
            </View>
        )
    }

    login() {
        console.log(this.state.userName, this.state.password);
    }

    register() {

    }
}