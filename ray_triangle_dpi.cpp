// ray_triangle_dpi.cpp
#include <cstdlib>
#include <ctime>

// DPI-C Interface (disable C++ name mangling)
extern "C" {
  // Initialize random seed
  void init_rand() {
    std::srand(std::time(nullptr));
  }

  // Generate test case (triangle, ray, and result)
  void generate_test_case(
    float *triangle,  // 9 floats: p0x,p0y,p0z, p1x,p1y,p1z, p2x,p2y,p2z
    float *ray_origin, // 3 floats: ex, ey, ez
    float *ray_dir,    // 3 floats: dx, dy, dz
    int   *result      // Intersection result (1 or 0)
  ) {
    // Generate random triangle vertices (-1.0 to 1.0)
    for (int i = 0; i < 9; i++) {
      triangle[i] = 2.0f * (std::rand() / (float)RAND_MAX) - 1.0f;
    }

    // Generate random ray origin (-1.0 to 1.0)
    for (int i = 0; i < 3; i++) {
      ray_origin[i] = 2.0f * (std::rand() / (float)RAND_MAX) - 1.0f;
    }

    // Generate random ray direction (-1.0 to 1.0)
    for (int i = 0; i < 3; i++) {
      ray_dir[i] = 2.0f * (std::rand() / (float)RAND_MAX) - 1.0f;
    }

    // Compute intersection result
    *result = compute_intersection(
      triangle, ray_origin, ray_dir
    );
  }
}

// Intersection logic (same as original code, refactored)
#include <cstdlib>
#include <ctime>
#include <cmath>

// DPI-C Interface
extern "C" {
  // Initialize random seed
  void init_rand() {
    std::srand(std::time(nullptr));
  }

  // Generate test case and compute intersection
  void generate_test_case(
    float *triangle,    // [p0x,p0y,p0z, p1x,p1y,p1z, p2x,p2y,p2z]
    float *ray_origin,  // [ex, ey, ez]
    float *ray_dir,     // [dx, dy, dz]
    int   *result       // Intersection result (1/0)
  ) {
    // Randomize triangle vertices (-1.0 to 1.0)
    for (int i = 0; i < 9; i++) {
      triangle[i] = 2.0f * (std::rand() / (float)RAND_MAX) - 1.0f;
    }

    // Randomize ray origin (-1.0 to 1.0)
    for (int i = 0; i < 3; i++) {
      ray_origin[i] = 2.0f * (std::rand() / (float)RAND_MAX) - 1.0f;
    }

    // Randomize ray direction (-1.0 to 1.0)
    for (int i = 0; i < 3; i++) {
      ray_dir[i] = 2.0f * (std::rand() / (float)RAND_MAX) - 1.0f;
    }

    *result = compute_intersection(triangle, ray_origin, ray_dir);
  }

  // Core intersection logic
  int compute_intersection(
    const float *triangle,
    const float *ray_origin,
    const float *ray_dir
  ) {
    // Extract triangle vertices
    const float &p0x = triangle[0], &p0y = triangle[1], &p0z = triangle[2];
    const float &p1x = triangle[3], &p1y = triangle[4], &p1z = triangle[5];
    const float &p2x = triangle[6], &p2y = triangle[7], &p2z = triangle[8];

    // Extract ray parameters
    const float &ex = ray_origin[0], &ey = ray_origin[1], &ez = ray_origin[2];
    const float &dx = ray_dir[0], &dy = ray_dir[1], &dz = ray_dir[2];

    // Compute triangle normal (e1 × e2)
    float e1x = p1x - p0x, e1y = p1y - p0y, e1z = p1z - p0z;
    float e2x = p2x - p0x, e2y = p2y - p0y, e2z = p2z - p0z;
    
    float nx = e1y*e2z - e1z*e2y;
    float ny = e1z*e2x - e1x*e2z;
    float nz = e1x*e2y - e1y*e2x;

    // Normalize normal vector
    float len_sq = nx*nx + ny*ny + nz*nz;
    if (len_sq < 1e-12f) return 0;  // Degenerate triangle

    // Newton-Raphson sqrt approximation
    float len = len_sq;
    for (int i = 0; i < 4; i++) {
      len = 0.5f * (len + len_sq/len);
    }
    nx /= len; ny /= len; nz /= len;

    // Ray-plane intersection
    float denom = dx*nx + dy*ny + dz*nz;
    if (fabs(denom) < 1e-8f) return 0;  // Ray parallel to plane

    float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
    if (t < 1e-6f) return 0;  // Intersection behind ray origin

    // Intersection point
    float ix = ex + dx*t;
    float iy = ey + dy*t;
    float iz = ez + dz*t;

    // Barycentric coordinate system
    float u, v, w;
    float ax = fabs(nx), ay = fabs(ny), az = fabs(nz);

    if (ax >= ay && ax >= az) {  // Project to YZ plane
      u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
      v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
      w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
    } else if (ay >= az) {       // Project to XZ plane
      u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
      v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
      w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
    } else {                    // Project to XY plane
      u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
      v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
      w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
    }

    // Normalize barycentric coordinates
    const float EPS = 1e-6f;
    if (fabs(w) < 1e-12f) return 0;
    u /= w;
    v /= w;

    return (u >= -EPS) && (v >= -EPS) && (u + v <= 1.0f + EPS) ? 1 : 0;
  }
}