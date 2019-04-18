import {Button, Input} from 'react-native-elements';
import {Component} from "react";
import * as React from "react";
import {View} from "react-native";


export class Login extends Component {
    render(): React.ReactNode {
        return (
            <View>
                <Input placeholder="输入账号"/>
                <Input placeholder="输入密码"/>
                <Button title="登录"/>
                <Button title="注册"/>
            </View>
        )
            ;
    }
}