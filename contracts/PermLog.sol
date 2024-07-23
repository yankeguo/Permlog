// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AccessControlDefaultAdminRules} from "@openzeppelin/contracts/access/extensions/AccessControlDefaultAdminRules.sol";

contract PermLog is AccessControlDefaultAdminRules {
    bytes32 public constant LOGGER_ROLE = keccak256("LOGGER_ROLE");

    constructor() AccessControlDefaultAdminRules(3 days, msg.sender) {
        _grantRole(LOGGER_ROLE, msg.sender);
    }

    event Log(string name, bytes content);

    function _log(string memory name, bytes memory content) internal {
        emit Log(name, content);
    }

    function log(
        string memory name,
        bytes memory content
    ) external onlyRole(LOGGER_ROLE) {
        _log(name, content);
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        virtual
        override(AccessControlDefaultAdminRules)
        returns (bool)
    {
        return AccessControlDefaultAdminRules.supportsInterface(interfaceId);
    }
}
