<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use App\Models\Serie;
use Illuminate\Http\Request;

class SerieController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $series = Serie::latest()->get();
        return view('series.index', compact('series'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:100',
            'code' => 'required|string|max:20|unique:series,code',
            'cycle' => 'required|string',
            'description' => 'nullable|string',
        ]);

        Serie::create($data);

        return redirect()->route('series.index')->with('success', 'Série ajoutée.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Serie $serie)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Serie $serie)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Serie $serie)
    {
        $data = $request->validate([
            'nom' => 'required|string|max:100',
            'code' => 'required|string|max:20|unique:series,code,' . $serie->id,
            'cycle' => 'required|string',
            'description' => 'nullable|string',
        ]);

        $serie->update($data);

        return redirect()->route('series.index')->with('success', 'Série mise à jour.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Serie $serie)
    {
        if ($serie->classes()->count() > 0) {
            return back()->with('error', 'Impossible de supprimer une série liée à des classes.');
        }
        $serie->delete();
        return redirect()->route('series.index')->with('success', 'Série supprimée.');
    }
}
