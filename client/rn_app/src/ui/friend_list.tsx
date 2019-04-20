import { ListItem, SearchBar} from 'react-native-elements';
import {Component} from "react";
import * as React from "react";
import {View} from "react-native";
import Icon from 'react-native-vector-icons/AntDesign';

interface Friend {
    id: number,
    name: string
    avatar_url: string,
    subtitle: string
}

interface State {
    friendList: Friend[],
    searchStr: string
}

let testItem = {
    id: 1,
    name: "猜猜",
    avatar_url: "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2900405061,1448955183&fm=27&gp=0.jpg",
    subtitle: "副标题"
};

export class FriendList extends Component<any, State> {
    constructor(props: any) {
        super(props);
        this.state = {
            friendList: [],
            searchStr: ""
        };
        for (let i = 0; i < 100; i++) {
            this.state.friendList.push(Object.assign({}, testItem));
            this.state.friendList[i].id = i;
        }
    }

    render(): React.ReactNode {
        return (
            <View>
                <SearchBar
                    searchIcon={<Icon name='search1' size={30}/>}
                    // todo cancel icon  invalid
                    cancelIcon={<Icon name='close' size={40} style={{color: "blue"}}/>}
                    placeholder="Type Here..."
                    onChangeText={(text) => this.UpdateSearch(text)}
                    onCancel={() => this.CancelSearch()}
                    value={this.state.searchStr}
                    containerStyle={{backgroundColor: "#fff"}}
                    inputContainerStyle={{backgroundColor: "#fff"}}
                />
                {
                    this.state.friendList.map((l, i) => (
                        <ListItem
                            key={i}
                            leftAvatar={{source: {uri: l.avatar_url}}}
                            title={l.name}
                            subtitle={l.subtitle}
                            onPress={() => this.SelectChatUser(l.id)}
                        />
                    ))
                }
            </View>
        )
    }

    UpdateSearch(text: string) {
        this.setState({searchStr: text});
    }

    CancelSearch() {

    }

    SelectChatUser(userID: number) {
        // console.log(userID);
    }

}