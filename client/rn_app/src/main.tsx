import * as React from 'react';
import {Login} from "./ui/login";


export default class Main extends React.Component {
    constructor(props: any) {
        super(props);
        this.state = {};
    }


    render(): React.ReactNode {
        return (
            <Login/>
        );
    }

}

