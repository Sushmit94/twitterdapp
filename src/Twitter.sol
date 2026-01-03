pragma solidity ^0.8.24;
contract Twitter{
    struct User{
        string username;
        string email;
        address addr;
    }
    User[] users;
    bool iscreated=false;
    struct posttype{
        string cont;
        uint256 no_of_likes;
        uint256 no_of_comments;
        string[] comments;
    }
    posttype[] public  allposts;
    mapping(address=>posttype[]) posts;
    

    function createAccount(string memory  _username,string memory _email) public {
        users.push(
            User({
                username:_username,
                email:_email,
                addr:msg.sender
            })
        );
        iscreated=true;
    }

    function post(string memory content) public{
        require(iscreated,"Create an account to post");
        posts[msg.sender].push(
            posttype({
            cont:content,
            no_of_likes:0,
            no_of_comments:0,
            comments: new string[](0)
        }));
    }   

    function like(uint256 postIndex) public{
        require(iscreated,"Create an account to post");
       posts[msg.sender][postIndex].no_of_likes += 1;

    }

    function comment(uint256 index,string memory comm) public{
        require(iscreated,"Create an account to comment");
        posts[msg.sender][index].comments.push(comm);
        posts[msg.sender][index].no_of_comments+=1;
    }

    function get_nooflikes(uint256 index) public view returns (uint256){
        return posts[msg.sender][index].no_of_likes;
    }

    function get_nofocomments(uint256 index) public view returns(uint256){
        return posts[msg.sender][index].no_of_comments;
    }

    function seecomments(uint256 index)public view returns( string[] memory ){
        return posts[msg.sender][index].comments;
    }
     

}