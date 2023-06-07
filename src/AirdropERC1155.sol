// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IERC1155} from "openzeppelin-contracts/contracts/token/ERC1155/IERC1155.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";
import {Multicall} from "openzeppelin-contracts/contracts/utils/Multicall.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {IAirdropERC1155} from "src/IAirdropERC1155.sol";

contract AirdropERC1155 is Ownable, ReentrancyGuard, Multicall, IAirdropERC1155 {
    error InvalidArrayLength();

    constructor() Ownable(msg.sender) {}

    /**
     *  @notice          Lets contract-owner send ERC1155 tokens to a list of addresses.
     *  @dev             The sender should approve target tokens to Airdrop contract,
     *                   which acts as operator for the tokens.
     *
     *  @param _tokenAddress    ERC1155 contract address
     *  @param _sender      Address of the sender
     *  @param _recipients      Airdrop recipients
     *  @param _amounts         Amount of tokens to airdrop to each recipient
     *  @param _tokenIds        List of ERC1155 tokenIds to airdrop
     */
    function airdrop(
        address _tokenAddress,
        address _sender,
        address[] memory _recipients,
        uint256[] memory _amounts,
        uint256[] memory _tokenIds
    ) external nonReentrant onlyOwner {
        uint256 len = _tokenIds.length;
        if (len == 0 || len != _recipients.length || len != _amounts.length) {
            revert InvalidArrayLength();
        }

        IERC1155 token = IERC1155(_tokenAddress);

        for (uint256 i = 0; i < len;) {
            token.safeTransferFrom(_sender, _recipients[i], _tokenIds[i], _amounts[i], "");
            unchecked {
                i += 1;
            }
        }
    }

    /**
     *  @notice          Lets contract-owner send ERC1155 tokens to a list of addresses.
     *  @dev             The sender should approve target tokens to Airdrop contract,
     *                   which acts as operator for the tokens.
     *
     *  @param _tokenAddress    ERC1155 contract address
     *  @param _sender      Address of the sender
     *  @param _recipients      Airdrop recipients
     *  @param _tokenId        TokenId to airdrop
     */
    function airdropSingle(address _tokenAddress, address _sender, address[] memory _recipients, uint256 _tokenId)
        external
        nonReentrant
        onlyOwner
    {
        IERC1155 token = IERC1155(_tokenAddress);

        uint256 len = _recipients.length;
        for (uint256 i = 0; i < len;) {
            token.safeTransferFrom(_sender, _recipients[i], _tokenId, 1, "");
            unchecked {
                i += 1;
            }
        }
    }
}
