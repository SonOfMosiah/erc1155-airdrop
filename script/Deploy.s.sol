// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {AirdropERC1155} from "src/AirdropERC1155.sol";

contract DeployScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        new AirdropERC1155();
        vm.stopBroadcast();
    }
}

// forge script script/Deploy.s.sol:DeployScript --rpc-url $POLYGON_RPC_URL --broadcast --etherscan-api-key $POLYGONSCAN_API_KEY --verify -vvvv
