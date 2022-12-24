import { MockContract } from '@ethereum-waffle/mock-contract';
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers';
import { MySlogan } from "../../typechain-types";

declare module "mocha" {
    export interface Context {
        signers: Signers;
        mocks: Mocks;
        lending: MySlogan;
    }
}

export interface Signers {
    deployer: SignerWithAddress;
    user1: SignerWithAddress;
    user2: SignerWithAddress;
}

export interface Mocks {
    mockUsdc: MockContract;
}