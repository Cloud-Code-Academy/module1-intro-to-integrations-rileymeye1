public class JSONPlaceholderExercise {
    private static final String BASE_URL = 'https://jsonplaceholder.typicode.com';
    
    /**
     * Exercise 1: Implement a GET request to fetch a post by ID
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to fetch
     * @return String - The JSON response from the API
     */
    public static String getPostById(Integer postId) {
        HttpResponse res = sendCallout(BASE_URL + '/posts/' + postId, 'GET', '');

        if (res.getStatusCode() >= 200 && res.getStatusCode() <= 299) {
            return res.getBody();
        } else {
            return 'An error occurred Response Code: ' + res.getStatusCode() + ' Response Status: ' + res.getStatus();
        }
    }
    
    /**
     * Exercise 2: Implement a POST request to create a new post
     * Endpoint: /posts
     * @param title - The title of the post
     * @param body - The body content of the post
     * @param userId - The user ID creating the post
     * @return String - The JSON response from the API
     */
    public static String createPost(String title, String body, Integer userId) {
        Post newPost = new Post(title, body, userId);

        HttpResponse res = sendCallout(BASE_URL + '/posts', 'POST', JSON.serialize(newPost));

        if (res.getStatusCode() >= 200 && res.getStatusCode() <= 299) {
            return res.getBody();
        } else {
            return 'An error occurred Response Code: ' + res.getStatusCode() + ' Response Status: ' + res.getStatus();
        }
    }
    
    /**
     * Exercise 3: Implement a PUT request to update a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to update
     * @param title - The new title
     * @param body - The new body content
     * @param userId - The user ID
     * @return String - The JSON response from the API
     */
    public static String updatePost(Integer postId, String title, String body, Integer userId) {
        Post updatedPost = new Post(postId, title, body, userId);

        HttpResponse res = sendCallout(BASE_URL + '/posts/' + postId, 'PUT', JSON.serialize(updatedPost));

        if (res.getStatusCode() >= 200 && res.getStatusCode() <= 299) {
            return res.getBody();
        } else {
            return 'An error occurred Response Code: ' + res.getStatusCode() + ' Response Status: ' + res.getStatus();
        }
    }
    
    /**
     * Exercise 4: Implement a PATCH request to partially update a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to patch
     * @param title - The new title (can be null)
     * @return String - The JSON response from the API
     */
    public static String patchPostTitle(Integer postId, String title) {
        Post updatedPost = new Post();
        updatedPost.postId = postId;
        updatedPost.title = title;

        HttpResponse res = sendCallout(BASE_URL + '/posts/' + postId, 'PATCH', JSON.serialize(updatedPost));

        if (res.getStatusCode() >= 200 && res.getStatusCode() <= 299) {
            return res.getBody();
        } else {
            return 'An error occurred Response Code: ' + res.getStatusCode() + ' Response Status: ' + res.getStatus();
        }
    }
    
    /**
     * Exercise 5: Implement a DELETE request to remove a post
     * Endpoint: /posts/{postId}
     * @param postId - The ID of the post to delete
     * @return Integer - The HTTP status code from the response
     */
    public static Integer deletePost(Integer postId) {
        HttpResponse res = sendCallout(BASE_URL + '/posts/' + postId, 'DELETE', '');
        return res.getStatusCode();
    }

    // Implemented this helper method to apply the principle of DRY (Don't Repeat Yourself)
    // I'm also lazy and don't want to write extra lines of code :)
    public static HttpResponse sendCallout(String endpoint, String method, String body) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(method);
        req.setBody(body);

        return http.send(req);
    }

    // Wrapper Class
    public class Post {
        public Integer postId;
        public String title;
        public String body;
        public Integer userId;

        // Used to create an empty Post object
        public Post() {}

        // Used to create a Post
        public Post(String title, String body, Integer userId) {
            this.title = title;
            this.body = body;
            this.userId = userId;
        }

        // Used to update an existing Post
        public Post(Integer postId, String title, String body, Integer userId) {
            this.postId = postId;
            this.title = title;
            this.body = body;
            this.userId = userId;
        }
    }
} 