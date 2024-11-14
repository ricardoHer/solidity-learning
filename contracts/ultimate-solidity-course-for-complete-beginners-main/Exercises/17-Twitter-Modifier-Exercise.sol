// SPDX-License-Identifier: MIT

// 1️⃣ Add a function called changeTweetLength to change max tweet length
// HINT: use newTweetLength as input for function
// 2️⃣ Create a constructor function to set an owner of contract
// 3️⃣ Create a modifier called onlyOwner
// 4️⃣ Use onlyOwner on the changeTweetLength function

pragma solidity ^0.8.0;

contract Twitter {

    uint16 public maxTweetLength = 280;
    address owner;

    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }
    mapping(address => Tweet[] ) public tweets;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner!");
        _;
    }

    function changeTweetLength (uint16 newTweetLength) public onlyOwner {
        maxTweetLength = newTweetLength;
    }

    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= maxTweetLength, "Tweet is too long bro!" );

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet( uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory ){
        return tweets[_owner];
    }

}