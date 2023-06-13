
import geopandas as gpd
import numpy as np


def venables(b, dist):
    v = np.dot(np.dot(b.T, dist), b)
    return v


def location_coef(x):
    cl = (np.sum(np.abs(x - (1 / len(x))))) / 2
    return cl


def uci(gdf, var_name):
    """
    python implementation of "github.com/rafapereirabr/urban_centrality_index_2013/blob/master/uci_function_sf.R"
    
    """

    # change projection to UTM
    gdf = gdf.to_crs(epsg=3857)

    # define boundary
    boundary = gdf.geometry.unary_union
    gdf_bound = gpd.GeoDataFrame(geometry=gpd.GeoSeries(boundary),crs=3857)

    # normalize distribution of variable
    var_x = gdf[var_name].values
    var_x_norm = var_x / np.sum(var_x)  # normalization

    # calculate distance matrix
    coords = gdf.centroid.to_crs(epsg=3857)
    dist = coords.geometry.apply(lambda g: coords.distance(g))
    dist = dist.to_numpy()

    # self distance
    n_reg = dist.shape[0]
    poly_areas = gdf.geometry.area.values
    self_dist = np.diag((poly_areas / np.pi) ** (1 / 2))
    dist += self_dist  # Sum dist matrix and self-dist

    # UCI and its components
    LC = location_coef(var_x_norm)

    # Spatial separation index (venables)
    v = venables(var_x_norm,dist)

    # Determine polygons on border
    boundary = gdf_bound.geometry.boundary[0]
    gdf['border'] = gdf.intersects(boundary).astype(float)
    b = gdf['border'].values
    b[np.isnan(b)] = 0.0
    b[b == 1] = 1 / len(b[b == 1])

    # MAX spatial separation
    # with all activities equally distributed along the border    
    v_max = venables(b,dist)

    # Proximity Index PI
    proximity_index = 1 - (v / v_max)

    # UCI
    UCI = LC * proximity_index

    return {'UCI': UCI,
            'location_coef': LC,
            'spatial_separation': v,
            'spatial_separation_max': v_max,
            }
