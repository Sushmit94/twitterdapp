// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "../src/Twitter.sol";

contract TwitterDeploy is Script {
    function run() external {
        vm.startBroadcast();
        new Twitter();
        vm.stopBroadcast();
    }
}
