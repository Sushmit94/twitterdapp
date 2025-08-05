pragma solidity ^0.8.20;

contract Twitter{

    uint16 MAX_TWEET_LENGTH = 280;

    struct Tweet{
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping (address => Tweet[]) public tweets;
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"You are not the owner");
        _;
    }

    event TweetCreated(uint256 id,address author,string content,uint256 timestamp);
    event TweetLiked(address liker,address tweetAuthor, uint256 tweetId,uint256 newLikeCount);
     event TweetUnliked(address unliker,address tweetAuthor, uint256 tweetId,uint256 newLikeCount);

    function changeTweetLenth(uint16 newTweetLength) public onlyOwner{
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function createTweet(string memory _tweet) public  {
        require(bytes(_tweet).length <=MAX_TWEET_LENGTH,"tweet is long");
       Tweet memory newTweet = Tweet({
        id:tweets[msg.sender].length,
        author: msg.sender,
        content:_tweet,
        timestamp: block.timestamp,
        likes: 0
       });
       tweets[msg.sender].push(newTweet);
       emit TweetCreated(newTweet.id,newTweet.author,newTweet.content,newTweet.timestamp);
    }

    function likeTweet(address author, uint256 id) public {
        require(tweets[author][id].id == id,"Tweet does not exist");
        tweets[author][id].likes++;
        emit TweetLiked(msg.sender,author,id,tweets[author][id].likes);
    }

    function unliketweets(address author , uint256 id) public{
          require(tweets[author][id].id == id,"Tweet does not exist");
          require(tweets[author][id].likes>0,"This tweet has 0 likes ,cannot dislike");
          tweets[author][id].likes++;
          emit TweetUnliked(msg.sender,author,id,tweets[author][id].likes);
    }

    function getTweet(address _owner, uint256 _i) public view returns(Tweet memory){
        return tweets[_owner][_i];
    }

    function getAllTweets(address _owner) public view returns(Tweet[] memory){
        return tweets[_owner];
    }

}
