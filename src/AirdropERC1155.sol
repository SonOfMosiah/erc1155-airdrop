// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/token/ERC1155/IERC1155.sol";
import "openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";
import "openzeppelin-contracts/contracts/utils/Multicall.sol";
import "openzeppelin-contracts/contracts/metatx/ERC2771Context.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "src/interfaces/airdrop/IAirdropERC1155.sol";

contract AirdropERC1155 is Ownable, ReentrancyGuard, ERC2771Context, Multicall, IAirdropERC1155 {
    error InvalidArrayLength();

    constructor() {}

    /**
     *  @notice          Lets contract-owner send ERC1155 tokens to a list of addresses.
     *  @dev             The sender should approve target tokens to Airdrop contract,
     *                   which acts as operator for the tokens.
     *
     *  @param _tokenAddress    ERC1155 contract address
     *  @param _tokenOwner      Address of the sender
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
     *  @param _tokenOwner      Address of the sender
     *  @param _recipients      Airdrop recipients
     *  @param _amounts         Amount of tokens to airdrop to each recipient
     *  @param _tokenId        TokenId to airdrop
     */
    function airdropSingle(
        address _tokenAddress,
        address _sender,
        address[] memory _recipients,
        uint256[] memory _amounts,
        uint256 _tokenId
    ) external nonReentrant onlyOwner {
        uint256 len = _tokenIds.length;
        if (len == 0 || len != _recipients.length || len != _amounts.length) {
            revert InvalidArrayLength();
        }

        IERC1155 token = IERC1155(_tokenAddress);

        for (uint256 i = 0; i < len;) {
            token.safeTransferFrom(_sender, _recipients[i], tokenId, _amounts[i], "");
            unchecked {
                i += 1;
            }
        }
    }
}
