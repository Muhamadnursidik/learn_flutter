<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Post;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class PostController extends Controller
{
    public function index()
    {
        $posts = Post::latest()->get();
        $res   = [
            'success' => true,
            'data'    => $posts,
            'message' => 'List post',
        ];
        return response()->json($res, 200);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title'   => 'required|string|max:155|unique:posts',
            'content' => 'required',
            'status'  => 'required',
            'foto'    => 'required|image|mimes:jpg,png,jpeg|max:2048',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $post          = new Post;
        $post->title   = $request->title;
        $post->slug    = Str::slug($request->title, '-');
        $post->content = $request->content;
        $post->status  = $request->status;

        if ($request->HasFile('foto')) {
            $path       = $request->file('foto')->store('posts', 'public');
            $post->foto = $path;
        }
        $post->save();

        $res = [
            'success' => true,
            'data'    => $post,
            'message' => 'Store post',
        ];
        return response()->json($res, 201);

    }

    public function show($id)
    {
        $post = Post::find($id);
        if (! $post) {
            return response()->json([
                'message' => "Data not found",
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data'    => $post,
            'message' => 'Data post found',
        ]);
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'title'   => 'required|string|max:155|unique:posts,id,' . $id,
            'content' => 'required',
            'status'  => 'required',
            'foto'    => 'nullable|image|mimes:jpg,png,jpeg|max:2048',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $post          = new Post;
        $post->title   = $request->title;
        $post->slug    = Str::slug($request->title, '-');
        $post->content = $request->content;
        $post->status  = $request->status;

        if ($request->hasFile('foto')) {
            if ($post->foto && Storage::disk('public')->exists($post->foto)) {
                Storage::disk('public')->delete($post->foto);
            }
            $path       = $request->file('foto')->store('posts', 'public');
            $post->foto = $path;
        }
        $post->save;

        $res = [
            'success' => true,
            'data'    => $post,
            'message' => 'Store post',
        ];
        return response()->json($res, 200);
    }

    public function destroy($id)
    {
        $post = Post::find($id);
        if (! $post) {
            return respnse()->json(['message' => 'Data Not found'], 404);
        }

        if ($post->foto && Storage::exsist('public/post/', $post->foto)) {
            Storage::delete('public/post/', $post->foto);
        }

        $post->delete();
        return response()->json([
            'success' => true,
            'message' => 'Post deleted successfully',
        ], 200);
    }
}
