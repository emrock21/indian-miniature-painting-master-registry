// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract IndianMiniaturePaintingMasterRegistry {

    struct PaintingStyle {
        string region;               // Rajasthan, Himachal Pradesh, Deccan, Tamil Nadu, etc.
        string schoolOrLineage;      // Mughal atelier, Mewar school, Kangra lineage, etc.
        string styleName;            // Mughal Miniature, Pahari, Deccan, Tanjore, etc.
        string pigments;             // lapis lazuli, malachite, gold leaf, indigo, vermilion
        string techniques;           // fine brushwork, burnishing, gold embossing, wasli preparation
        string iconography;          // court scenes, epics, ragamalas, deities, nature
        string uniqueness;           // stylistic or cultural distinctiveness
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct StyleInput {
        string region;
        string schoolOrLineage;
        string styleName;
        string pigments;
        string techniques;
        string iconography;
        string uniqueness;
    }

    PaintingStyle[] public styles;

    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event StyleRecorded(
        uint256 indexed id,
        string styleName,
        string schoolOrLineage,
        address indexed creator
    );

    event StyleVoted(
        uint256 indexed id,
        bool like,
        uint256 likes,
        uint256 dislikes
    );

    constructor() {
        styles.push(
            PaintingStyle({
                region: "India",
                schoolOrLineage: "ExampleSchool",
                styleName: "Example Style (replace with real entries)",
                pigments: "example pigments",
                techniques: "example techniques",
                iconography: "example iconography",
                uniqueness: "example uniqueness",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordStyle(StyleInput calldata s) external {
        styles.push(
            PaintingStyle({
                region: s.region,
                schoolOrLineage: s.schoolOrLineage,
                styleName: s.styleName,
                pigments: s.pigments,
                techniques: s.techniques,
                iconography: s.iconography,
                uniqueness: s.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit StyleRecorded(
            styles.length - 1,
            s.styleName,
            s.schoolOrLineage,
            msg.sender
        );
    }

    function voteStyle(uint256 id, bool like) external {
        require(id < styles.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;

        PaintingStyle storage p = styles[id];

        if (like) {
            p.likes += 1;
        } else {
            p.dislikes += 1;
        }

        emit StyleVoted(id, like, p.likes, p.dislikes);
    }

    function totalStyles() external view returns (uint256) {
        return styles.length;
    }
}
