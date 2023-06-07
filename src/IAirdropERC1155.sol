// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.19;

interface IAirdropERC1155 {
    /**
     *  @notice          Lets contract-owner send ERC1155 tokens to a list of addresses.
     *  @dev             The token-owner should approve target tokens to Airdrop contract,
     *                   which acts as operator for the tokens.
     *
     *  @param _tokenAddress    Contract address of ERC1155 tokens to air-drop.
     *  @param _sender      Address from which to transfer tokens.
     *  @param _recipients      List of recipient addresses for the air-drop.
     *  @param _amounts         Quantity of tokens to air-drop, per recipient.
     *  @param _tokenIds        List of ERC1155 token-Ids to drop.
     */
    function airdrop(
        address _tokenAddress,
        address _sender,
        address[] memory _recipients,
        uint256[] memory _amounts,
        uint256[] memory _tokenIds
    ) external;

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
        external;
}
