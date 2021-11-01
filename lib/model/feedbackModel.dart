class FeedBackModel {
  String comments;
  double ratings;

  FeedBackModel(this.comments, this.ratings);

  @override
  String toString() {
    return 'FeedBackModel{comments: $comments, ratings: $ratings}';
  }
}
